/*
 * Wires QZ Tray request signing so the "Allow this site to print?" popup
 * QZ Tray otherwise shows on *every* privileged call (connect, find
 * printers, print) stops appearing — QZ Tray only prompts for unsigned
 * connections. Adapted from QZ Industries' own reference implementation
 * (qzind/tray, assets/signing/sign-message.js) — same shape, just the
 * private key swapped for one generated for this app (never QZ's public
 * demo key, which is posted on GitHub and explicitly not a secret).
 *
 * Depends on jsrsasign-all-min.js (loaded before this file) and qz-tray.js
 * (loaded before jsrsasign-all-min.js — see web/index.html for order).
 *
 * SECURITY NOTE — deliberate tradeoff, not an oversight: this private key
 * ships inside this file, which any browser can view-source. That's only
 * acceptable because this app is a single shop's own desktop/kiosk
 * printing setup, not a public multi-tenant deployment — anyone able to
 * extract this key already has the same browser access needed to hit
 * "Allow" on the popup this key is replacing. If this ever becomes a
 * public multi-tenant deployment, move signing to a backend endpoint
 * instead (the key must never ship client-side at that point) — see
 * thermal-printer-implementation-plan.md.
 */
(function () {
  var privateKey =
    '-----BEGIN PRIVATE KEY-----\n' +
    'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDfGr3YP5eft9Z8\n' +
    'hQIwrwJqJQR8jgh6LkDqhu9cPABwHAMiGLHUFkySWHtP71uH1D4FGoUmepx5Acz8\n' +
    'AcvWLX3K4drQSIILReopzBe2/JIVLouwKz+Lgwb5SICI+oO8qeWQinAaRCUJRjUi\n' +
    'sXjsmG7L7iKB6km0q/GA4KR2vVYgRMGXu6K+KjXmJKZSSWIYHJEiVxe3ITWTlAsL\n' +
    'N/DyTAv/jnuFXuptclbMltimMq0h1yG723NRZOpkrQ9fAraXjCbeOE4RJVuTsUz/\n' +
    'xBrrBUPpldg/vRj81GagmXP6DP874V+evuygjuKoZLCbsAQmpImjR5/EsaETvUR/\n' +
    'LeJ3obVbAgMBAAECggEAGB2f37wf+5e3i4YlEnYYYLjXn08LA4n0YmVrgiDKO1QL\n' +
    '0qewsSgn5rnBuoY48pmyioKvWdVvDHVxXtwi2GfabQ+0w0bTJ7zK7vGsro7mi3uY\n' +
    'hdZm7AGhw1he7G+HxeDne5Q7QduT1UjNfY6Jb6macFixSjG0/d6IIFIn9N3KbXpN\n' +
    'bAjCF8J5OMBlPoz184r68GFtFcVRXC2gQn7Sniy9LHcphs6tAxgbAj2Z6Vz44LsI\n' +
    'i0e2Z+2tASKv+7KNBJXmg3b/dzQdexpAA+bdaAf9LmNTsG/mJbcd6l3WnkqCVatc\n' +
    '10ICgPXwzK2GsgGavmryUMAjdgHZp1R79CIvvyusQQKBgQD5hTo6CgrWcPZm6re/\n' +
    'P+u+882z6ODyO7Z6Gq+hiIOG8KTKokJcZ4sMKrtTUjBKTJnZAi8xw2XYja/f+Ny+\n' +
    'xRncKzPQL0CDIdjLR3cwgR40Zl/WC0k3qAXxm+7fNnmLygRahtfGRRCaSDyEozz8\n' +
    'oq+NcbBY81plTZXDkKfH3gTfUwKBgQDk5eesn7hqwr8ECDrjJsr3pMQrULGfXkMr\n' +
    'ddd75h7XHqgjJ+kZ4nK1FOXsSTVU5P+oxKZEv24NHNF9g9WSYN5N1H+wG0u9uySS\n' +
    'jfzJfvTkyLjAllQhTx+QSOdByXY6oTb8CVhFChhPgi/bCe3e5VLFtXo21u5NONnC\n' +
    '0yBYITj42QKBgCtuG/9kJhTDHrA1JHxeVNsstl4dJ6Ih8JX6NR2plDMVialXarOI\n' +
    'tjQM8AQFpzAXeyPBdJN1zjFOIBGc0FdIGUMwJdmTj+gDKSfgrYc8whQeyYmI91p/\n' +
    'nWE7Ye1qHufM5ssW81GoTcZ80kPH4eKbMnEtG6Ov38kIIwwiDoIES9bPAoGAf1wQ\n' +
    'oPMp2HVNdT/jDBq8mjgaUoOOoT8AnsDtyemLxWQwZ4dAYv+llW3wVJ2TSA421j+8\n' +
    'x8m/wRoE0hK1lcHCT4nqFiHJ7eKgAc9xFOhH+LhaXAYI/5OX219FFUy0NQEYp/nH\n' +
    'HHr2dd7ZI8YNjZUJjipguvyyEVONjqKMf5zUp1kCgYAuuru/ghonWv5bWumuKqoh\n' +
    'a0RHyenpM2/sGn0N1eH80w7K8uFs0Wd8Br2NCCeUid3keuBemrzdMXghNGkzENN3\n' +
    '3SJQlScbhpoapmvTTY1P76KLMe91mG4D/j/uoATFqfiy9GgQ7Ctr8OEq1+7ACxg0\n' +
    'pMIjG/e66YAyBVpkuHbcrg==\n' +
    '-----END PRIVATE KEY-----';

  // Public certificate, matching `privateKey` above (self-signed, 10-year
  // validity — see web/qz/digital-certificate.txt, the same file, kept as
  // its own asset too since some QZ Tray flows fetch it independently).
  // Fetched from the same host it's served from (no CDN dependency).
  qz.security.setCertificatePromise(function (resolve, reject) {
    fetch('qz/digital-certificate.txt')
      .then(function (response) { return response.text(); })
      .then(resolve)
      .catch(reject);
  });

  qz.security.setSignatureAlgorithm('SHA512');
  qz.security.setSignaturePromise(function (toSign) {
    return function (resolve, reject) {
      try {
        var pk = KEYUTIL.getKey(privateKey);
        var sig = new KJUR.crypto.Signature({ alg: 'SHA512withRSA' });
        sig.init(pk);
        sig.updateString(toSign);
        var hex = sig.sign();
        resolve(stob64(hextorstr(hex)));
      } catch (err) {
        reject(err);
      }
    };
  });
})();
