// openshift.withCluster() {
//   env.NAMESPACE = openshift.project()
//   env.APP_NAME = "${env.JOB_NAME}".replaceAll(/-?pipeline-?/, '').replaceAll(/-?${env.NAMESPACE}-?/, '')
//   echo "Starting Pipeline for ${APP_NAME}..."
//   def projectBase = "${env.NAMESPACE}".replaceAll(/-dev/, '')
//   env.STAGE1 = "${projectBase}-dev"
//   env.STAGE2 = "${projectBase}-stage"
//   env.STAGE3 = "${projectBase}-prod"
// }


pipeline {

    parameters {

        booleanParam(defaultValue: false,description: 'Deploy to Prod Environment ?', name: 'DEPLOY_PROD')
        string(defaultValue: "sdwa-asda", description: 'Maven Settings File Id', name: 'MAVEN_SETTINGS_ID')
        string(defaultValue: "http://baifuseqa01.internal.com/nexus", description: 'Nexus URL', name: 'NEXUS_URL')
        string(defaultValue: "artifacts", description: 'Nexus hosted repo name', name: 'NEXUS_HOSTED_NAME_RELEASES')
        string(defaultValue: "artifacts-snapshots", description: 'Nexus hosted snapshots repo name', name: 'NEXUS_HOSTED_NAME_SNAPSHOTS')

        string(defaultValue: '', name: 'EMAIL_RECIPIENT_LIST')
    }
    
    options {
        
        // use colors in Jenkins console output
        ansiColor('xterm')
        
        // discard old builds
        buildDiscarder logRotator(daysToKeepStr: '30', numToKeepStr: '45')
        
        // disable concurrent builds and disable build resume
        disableConcurrentBuilds()
        disableResume()

        // timeout on whole pipeline job
        timeout(time: 2, unit: 'HOURS')
    }
    
    triggers {
        pollSCM "*/2 * * * *"
    }

    environment {

        PLACEHOLDER_VARIABLE   = 'TBD'
    }


  
stages {

    stage("Initialize") {
        
        steps {
            script {
                    // notifyBuild('STARTED')
                    echo "Build number: ${BUILD_NUMBER} - Build id: ${env.BUILD_ID} on Jenkins instance: ${env.JENKINS_URL}"

                    echo "Deploy to QA? :: ${params.DEPLOY_QA}"

                    echo "Maven Settings file id? :: ${params.MAVEN_SETTINGS_ID}"
                    echo "NEXUS URL? :: ${params.NEXUS_URL}"
                    sh "printenv | sort"
            }
        }
    }

    stage('Code Build and Test') {

        agent { label 'maven' }
        steps {

            configFileProvider([configFile(fileId: "${params.MAVEN_SETTINGS_ID}", variable: 'MAVEN_SETTINGS')]) {
                
                sh "mvn -U -B clean package -s ${MAVEN_SETTINGS}"
                // sh "./mvnw -U clean package -Pnexus-deploy -Dnexus.base.url=${NEXUS_URL} -Dnexus.hosted.name.releases=${NEXUS_HOSTED_NAME_RELEASES} -Dnexus.hosted.name.snapshots=${NEXUS_HOSTED_NAME_SNAPSHOTS} -s ${MAVEN_SETTINGS}"
            }
            
            // git url: "${SOURCE_CODE_URL}"
            // sh "mvn -B clean install -q"
        }
    }

    // stage('Image Build') {

    //     agent { label 'buildah' }

    //     when {
    //         // fake condition for now
    //         branch 'master' 
    //     }

    //     steps {
    //         echo 'Building Image from Jar File'
            
    //     }
    // }

    // stage('Push Docker Image') {
    //     when {
    //         branch 'master'
    //     }
        
    //     steps {
    //         script {

    //         }
    //     }
    // }

    // stage('Update GitOps Repo') {
    //     when {
    //         branch 'master'
    //     }
        
    //     steps {
 
    //     }
    // }

    

    // stage ('Verify Deployment to Dev') {
    //   steps {
    //     script {
    //       openshift.withCluster() {
    //         def dcObj = openshift.selector('dc', env.APP_NAME).object()
    //         def podSelector = openshift.selector('pod', [deployment: "${APP_NAME}-${dcObj.status.latestVersion}"])
    //         podSelector.untilEach {
    //             echo "pod: ${it.name()}"
    //             return it.object().status.containerStatuses[0].ready
    //         }
    //       }
    //     }
    //   }
    // }

    // stage('Promote to Stage') {
    //   steps {
    //     script {
    //       openshift.withCluster() {
    //         openshift.tag("${env.STAGE1}/${env.APP_NAME}:latest", "${env.STAGE2}/${env.APP_NAME}:latest")
    //       }
    //     }
    //   }
    // }

    // stage ('Verify Deployment to Stage') {
    //   steps {
    //     script {
    //       openshift.withCluster() {
    //           openshift.withProject("${STAGE2}") {
    //           def dcObj = openshift.selector('dc', env.APP_NAME).object()
    //           def podSelector = openshift.selector('pod', [deployment: "${APP_NAME}-${dcObj.status.latestVersion}"])
    //           podSelector.untilEach {
    //               echo "pod: ${it.name()}"
    //               return it.object().status.containerStatuses[0].ready
    //           }
    //         }
    //       }
    //     }
    //   }
    // }

    // stage('Promote to Prod') {
    //   steps {
    //     withDockerRegistry([credentialsId: "${STAGE1}-nonprod-credentials", url: "${SRC_API_URL}"]) {

    //       withDockerRegistry([credentialsId: "${STAGE1}-prod-credentials", url: "${DEST_API_URL}"]) {

    //         sh """
    //             oc image mirror --insecure=true ${SRC_REGISTRY}/${STAGE2}/${APP_NAME}:latest ${DEST_REGISTRY}/${STAGE3}/${APP_NAME}:latest 
    //           """

    //         }
    //       }
    //     }
    //   }

    // stage ('Verify Deployment to Prod') {
    //   steps {
    //     script {
    //       openshift.withCluster() {
    //         def secretData = openshift.selector('secret/prod-cluster-credentials').object().data
    //         def encodedAPI = secretData.api
    //         def encodedToken = secretData.token
    //         env.API = sh(script:"set +x; echo ${encodedAPI} | base64 --decode", returnStdout: true).replaceAll(/https?/, 'insecure')
    //         env.TOKEN = sh(script:"set +x; echo ${encodedToken} | base64 --decode", returnStdout: true)
    //       }
    //       openshift.withCluster( env.API, env.TOKEN ) {
    //         openshift.withProject("${STAGE3}") {
    //           def dcObj = openshift.selector('dc', env.APP_NAME).object()
    //           def podSelector = openshift.selector('pod', [deployment: "${APP_NAME}-${dcObj.status.latestVersion}"])
    //           podSelector.untilEach {
    //               echo "pod: ${it.name()}"
    //               return it.object().status.containerStatuses[0].ready
    //           }
    //         }
    //       }
    //     }
    //   }
    // }

  }

    post {

        // stage executed always, regardless of the completion status of the Pipeline’s or stage’s run
        always {
            node('master') {
                
                // dir('widgets') {
                   
                //     // publish screenshots of failed integration tests, if any
                //     publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'cypress/cypress/screenshots', reportFiles: '**', reportName: 'Cypress screenshots', reportTitles: ''])
                   
                //     // publish videos of the tests, if any
                //     publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'cypress/cypress/videos', reportFiles: '**', reportName: 'Cypress videos', reportTitles: ''])
                // }
                
                // send an email with the build result to the specified recipients
                emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                    to: "${EMAIL_RECIPIENT_LIST}",
                    subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            }
        }
        
        // stage executed after every other post condition has been evaluated, regardless of the Pipeline or stage’s status.
        cleanup {
            node('master') {
                // clean up the pipeline workspace
                cleanWs()
            }
        }
    }

}