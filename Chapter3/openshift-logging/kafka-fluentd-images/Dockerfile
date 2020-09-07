FROM registry.access.redhat.com/openshift3/logging-fluentd:v3.11

ADD base.repo /etc/yum.repos.d/
RUN yum -y install --setopt=tsflags=nodocs \
    gcc-c++ ruby-devel patch make iputils net-tools telnet && \
    yum clean all && \
    rm -rf /etc/yum.repos.d/base.repo

ADD kafka-plugin/ ${HOME}/
WORKDIR ${HOME}
RUN fluent-gem install 0.1.3/zookeeper-1.4.11.gem --local && \
    fluent-gem install 0.1.3/zk-1.9.6.gem --local && \
    fluent-gem install 0.1.3/poseidon-0.0.5.gem --local && \
    fluent-gem install 0.1.3/poseidon_cluster-0.3.3.gem --local && \
    fluent-gem install 0.1.3/ltsv-0.1.0.gem --local && \
    fluent-gem install 0.1.3/fluent-plugin-kafka-0.1.3.gem --local

ADD run.sh  ${HOME}/

USER 0
CMD ["sh", "run.sh"]
