include:
  - .common
  - .aliases-helper

/etc/exim4/exim4.conf:
    file.managed:
      - source: salt://exim/relay.conf
      - template: jinja
      - defaults:
            dkim_selector: support
      - mode: 644 
      - user: root
      - group: root
      - require:
          - pkg: exim4-daemon-light

exim4-dkim:
    cmd.run:
      - name: openssl genrsa -out /etc/exim4/dkim.key 1024
      - umask: 027
      - group: Debian-exim
      - creates: /etc/exim4/dkim.key
      - require:
          - pkg: exim4-daemon-light

exim4-dkim-pub:
    cmd.run:
      - name: |
            openssl rsa -in /etc/exim4/dkim.key \
                        -out /etc/exim4/dkim.public.key \
                        -pubout -outform PEM
      - creates: /etc/exim4/dkim.public.key
      - require:
          - cmd: exim4-dkim

extend:
    exim4:
        service.running:
          - watch:
              - file: /etc/aliases
              - cmd: exim4-dkim
