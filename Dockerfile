FROM centos:centos6.9

EXPOSE 22

ENV DEBIAN_FRONTEND noninteractive

# yum
# YumRepo Error: All mirror URLs are not using ftp, http[s] or file.」 エラー対応開始
# １．リポジトリリスト (/etc/yum.repos.d/CentOS-Base.repo)をコピーしてバックアップする
RUN cp -p /etc/yum.repos.d/CentOS-Base.repo  /etc/yum.repos.d/CentOS-Base.repo_bak

# ２．mirrorlist=http://mirrorlist.centos.org に箇所をコメントアウトする
RUN sed -i -e "s/^mirrorlist=http:\/\/mirrorlist.centos.org/#mirrorlist=http:\/\/mirrorlist.centos.org/g" /etc/yum.repos.d/CentOS-Base.repo

# ３．#baseurl=http://mirror.centos.org/baseurl　の箇所を、baseurl=http://vault.centos.org/ に変更する

RUN sed -i -e "s/^#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/g" /etc/yum.repos.d/CentOS-Base.repo
# YumRepo Error: All mirror URLs are not using ftp, http[s] or file.」 エラー対応終了

RUN yum -y update && yum clean all

# locale
RUN yum reinstall -y glibc-common
RUN localedef -i ja_JP -f UTF-8 ja_JP.utf8
RUN touch /etc/sysconfig/i18n
RUN echo 'LANG="ja_JP.UTF-8"' >> /etc/sysconfig/i18n
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja

# timezone
RUN yum install -y tzdata
RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN echo 'UTC=false' >> /etc/sysconfig/clock
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# tools
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y --enablerepo centosplus wget curl vim emacs tar unzip mlocate perl ssh openssh-server openssl-devel

# root passwd
RUN bash -c 'echo "root:password" | chpasswd'

# ssh
RUN sed -i -e "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
RUN sed -i -e "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i -e "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config

RUN updatedb

CMD /etc/init.d/sshd restart && /bin/bash