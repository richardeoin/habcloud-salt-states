{% for user, data in pillar["auth"]["users"].items() %}
user-{{ user }}:
    group.present:
      - name: {{ user }}
      - gid: {{ data.uid }}
      - system: False
    user.present:
      - name: {{ user }}
      - password: "!"
      - home: /home/{{ user }}
      - shell: /bin/bash
      - uid: {{ data.uid }}
      - gid_from_name: True
      - fullname: {{ data.fullname }}
      - remove_groups: False
      - require:
          - group: {{ user }}
    file.managed:
      - name: /home/{{ user }}/.ssh/authorized_keys
      - mode: 600
      - user: {{ user }}
      - group: {{ user }}
      - contents_pillar: auth:users:{{ user }}:ssh_keys
      - makedirs: true
      - dir_mode: 700
      - require:
          - user: {{ user }}
{% endfor %}

{% for user in pillar["auth"]["purged_users"] %}
purge-user-{{ user }}:
    user.absent:
        - name: {{ user }}
{% endfor %}

{% for group, members in pillar["auth"]["groups"][grains.id].items() %}
group-{{ group }}:
    group.present:
        - name: {{ group }}
        - system: {{ "true" if group in ("sudo", "users") else "false" }}
        - members:
          {% for member in members %}
            - {{ member }}
          {% endfor %}
          {% if group == "users" %}
          {% for member in pillar["auth"]["groups"][grains.id]["sudo"] %}
            - {{ member }}
          {% endfor %}
          {% endif %}
{% endfor %}

root:
    user.present:
      - password: "!"

sudo:
    pkg:
      - installed

/etc/sudoers:
    file.managed:
      - source: salt://auth/sudoers
      - mode: 440
      - user: root
      - group: root
      - require:
          - pkg: sudo
