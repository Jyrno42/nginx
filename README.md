# nginx

This is a fork of nginx which attempts to change ssl_verify_client to be location based. This improves
Estonian ID-Card (esteid) support in nginx by allowing one to have a login/logout process without separate
servers.

The implementation is loosely based on how it's done in Apache.

# Roadmap

 - [x] Allow `ssl_verify_client` at location level
 - [x] Move ssl_context from `server_t` to `location_t`
 - [ ] When `ssl_verify_client` level changes use secure renegotiation to ask for a client cert:
     - [x] Rough renegotiation with CPU hammering (SSL_peek until the renegotiation has been completed)
     - [x] Reduce CPU hammering by using a timer
     - [x] Ensure ssl connection gets their own client_CA_list (not a pointer to the list inside CTX)
     - [ ] Only re-negotiate when necessary (off -> optional | on | optional-no-ca and vice-versa)
     - [ ] Optimized renegotiation (reuse previous certs)
 - [ ] Run ssllabs tests and tune code accordingly
 - [ ] Ensure safeguards against CVE-2009-3555 still work
 - [ ] Are we SPEC yet?
