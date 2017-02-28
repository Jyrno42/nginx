# nginx

This is a fork of nginx which attempts to change ssl_verify_client to be location based. This improves
Estonian ID-Card (esteid) support in nginx by allowing one to have a login/logout process without separate
servers.

The implementation is loosely based on how it's done in Apache.

## Why a fork?

Since the nginx dev team marked the [issue](https://trac.nginx.org/nginx/ticket/317) as wontfix (in 2013) the
only way forward is to build the functionality in the userland. I also plan to submit the results of this
experiment as a patch to nginx.

# Roadmap

 - [x] Allow `ssl_verify_client` at location level
 - [x] Move ssl_context from `server_t` to `location_t`
 - [x] Add `ssl_crl_dir` configuration option which can be used to load crls from a directory
 - [x] Add `ssl_crl_check_mode=none | chain | leaf` which can be used to control how CRL -s are 
        checked (makes esteid CRLs work in nginx)
 - [x] Add `ssl_crl_dir` and `ssl_crl_check_mode` to http_proxy, http_uwsgi, mail_ssl, stream_proxy and
        stream_ssl modules.
 - [ ] When `ssl_verify_client` level changes use secure renegotiation to ask for a client cert:
     - [x] Rough renegotiation with CPU hammering (SSL_peek until the renegotiation has been completed)
     - [x] Reduce CPU hammering by using a timer
     - [x] Ensure ssl connection gets their own client_CA_list (not a pointer to the list inside CTX)
     - [ ] Only re-negotiate when necessary (off -> optional | on | optional-no-ca and vice-versa)
     - [ ] Optimized renegotiation (reuse previous certs)
 - [ ] Run ssllabs tests and tune code accordingly
 - [ ] Ensure safeguards against CVE-2009-3555 still work
 - [ ] Are we SPEC yet?
 - [ ] Send patch to nginx with `ssl_crl_dir` and `ssl_crl_check_mode` logic
 - [ ] Send patch to nginx with per-location `ssl_verify_client` 
