/*
 * Varnish Workbench VCL
 *
 * This Varnish VCL extends the default VLC by adding
 * PURGE/BAN/REFRESH support. For this demonstration we added
 * some further modifications which include:
 *
 *  - Remove the jQuery AJAX nocache GET parameter
 *  - Add debug output to the headers.
 *  - Make the cache client.ip sensitiv.
 *
 */

/*
 * Localhost as Backend
 */
backend default {
    .host = "127.0.0.1";
    .port = "80";
    .connect_timeout = 5s;
    .first_byte_timeout = 600s;
    .between_bytes_timeout = 600s;
}

/*
 * Allow PURGE, BAN and REFRESH only from those IPs.
 */
acl purge {
    "127.0.0.1";
}

/*
 * Handle received requests
 */
sub vcl_recv {
    // Save Client IP to X-Forwarded-For
    set req.http.X-Forwarded-For = client.ip;

    // Strip the jQuery no-cache option
    if (req.url ~ "(\?|\&)_=[0-9]+" ) {
        set req.url = regsub(req.url, "(\?|\&)_=[0-9]+", "");
    }

    // Get the IP the cache is for
    if (!req.http.X-Cache-For) {
        set req.http.X-Cache-For = client.ip;
    }

    // Lookup PURGE
    if (req.request == "PURGE") {
        if (!client.ip ~ purge) { error 405 "Not allowed."; }
        return (lookup);
    }
    // Add BAN to the list
    if (req.request == "BAN") {
        if (!client.ip ~ purge) { error 405 "Not allowed."; }
        ban("obj.http.x-ban-url ~ " + req.http.x-ban-url +
            " && obj.http.x-ban-host ~ " + req.http.x-ban-host +
            " && obj.http.x-ban-ip ~ " + req.http.X-Cache-For);
        error 200 "Banned";
    }
    // Bypass a cache hit
    if (req.request == "REFRESH") {
        if (!client.ip ~ purge) { error 405 "Not allowed."; }
        set req.request = "GET";
        set req.hash_always_miss = true;
    }
}

/*
 * Modify page received from backend
 */
sub vcl_fetch {
    // Remember request host, url and IP for purging
    set beresp.http.x-ban-url = req.url;
    set beresp.http.x-ban-host = req.http.host;
    set beresp.http.x-ban-ip = req.http.X-Cache-For;

    // Save the Varnish TTL
    set beresp.http.X-Varnish-Ttl = beresp.ttl;

    // Will Varnish cache this
    if (beresp.ttl <= 0s) {
        set beresp.http.X-Varnish-Cacheable = "NO: Not Cacheable";
    } else {
        set beresp.http.X-Varnish-Cacheable = "YES";
    }
}

/*
 * PURGE handling for cache hits
 */
sub vcl_hit {
    if (req.request == "PURGE") {
        purge;
        error 200 "Purged";
    }
}

/*
 * PURGE handling for cache misses.
 */
sub vcl_miss {
    if (req.request == "PURGE") {
        purge;
        error 200 "Purged";
    }
}

/*
 * Send Object to Client
 */
sub vcl_deliver {
    // Set Hit/Miss Headeri
    if (obj.hits > 0) {
        set resp.http.X-Varnish-Cache = "HIT";
    }
    else {
        set resp.http.X-Varnish-Cache = "MISS";
    }

    // Remove internal informations
    unset resp.http.x-ban-url;
    unset resp.http.x-ban-host;
    unset resp.http.x-ban-ip;
}

/*
 * Add X-Cache-For to the Hash to allow each user to have it's own cache.
 */
sub vcl_hash {
    hash_data(req.http.X-Cache-For);
}
