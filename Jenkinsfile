import groovy.json.JsonSlurperClassic

node{
    def SF_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH 
    def SF_USERNAME=env.USERNAME
    def SERVER_KEY_CREDENTALS_ID=env.JWT_CRED_ID_DH
    def TEST_LEVEL='RunLocalTests'
    def PACKAGE_NAME='0Ho1U000000CaUzSAK'
    def PACKAGE_VERSION
    def SF_INSTANCE_URL = env.SF_INSTANCE_URL ?: "https://login.salesforce.com"


        stage('checkout source') {
            // when running in multi-branch job, one must issue this command
            checkout scm
        }
        withEnv(["HOME=${env.WORKSPACE}"]){
            withCredentials([file(credentialsId: SERVER_KEY_CREDENTALS_ID, variable: 'server_key_file')]) {

            // -------------------------------------------------------------------------
            // Authorize the Dev Hub org with JWT key and give it an alias.
            // -------------------------------------------------------------------------

                stage('Authorize Dev Org') {
                    rc = command "sf org login jwt --instance-url ${SF_INSTANCE_URL} --client-id ${SF_CONSUMER_KEY} --username ${SF_USERNAME} --jwt-key-file ${server_key_file} --set-default-dev-hub --alias DevOrg"
                    if (rc != 0) {
                        error 'Salesforce dev hub org authorization failed.'
                    }else{
                        echo "Dev org authorized successfully."
                    }
                }
            }
        }

}

def command(script) {
    if (isUnix()) {
        return sh(returnStatus: true, script: script);
    } else {
        return bat(returnStatus: true, script: script);
    }
}