include:
    - nginx
    - .dl_fldigi_version_check

extend:
    nginx:
        service:
            - watch:
                - file: /etc/nginx/conf.d/habhub.org.conf
                - git: habhub-homepage
                - git: cusf-burst-calc

/etc/nginx/conf.d/habhub.org.conf:
    file.managed:
        - source: salt://habhub/nginx-site.conf
        - template: jinja

habhub-homepage:
    git.latest:
        - name: https://github.com/ukhas/habhub-homepage.git
        - target: /srv/habhub-homepage
        - force: true
        - rev: master
        - always_fetch: true
        - submodules: true

cusf-burst-calc:
    git.latest:
        - name: https://github.com/ukhas/cusf-burst-calc.git
        - target: /srv/cusf-burst-calc
        - force: true
        - rev: master
        - always_fetch: true
        - submodules: true