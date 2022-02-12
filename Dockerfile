FROM centos:7

LABEL maintainer="Michael Buluma <ne@buluma.co.ke>"
LABEL build_date="2022-02-12"

WORKDIR /github/workspace

RUN dnf install -y rpmdevtools dnf-utils spectool dnf-utils && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
