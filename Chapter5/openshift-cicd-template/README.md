# openshift-cicd-template

注意：
1. 如果project名称不是myapp，则需要修改myapp-template-no-trigger.yaml的image字段:
image: docker-registry.default.svc:5000/<your_project_name>/${APPLICATION_NAME}:latest
2. 如果project名称部署myapp，则需要修改Jenkinsfile中项目的定义：
def devProject = "<your_project_name>"
3. 如果jenkins所在的project与部署应用所在的project不是同一个，则需要执行如下命令赋予权限：
oc policy add-role-to-user edit system:serviceaccount:<jenkins_project_name>:jenkins -n <myapp_project_name>
