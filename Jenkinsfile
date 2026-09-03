pipeline {
    agent none
    triggers{
        upstream(upstreamProjects: 'UCSB-PSTAT GitHub/base-rstudio/main', threshold: hudson.model.Result.SUCCESS)
    }
    environment {
        IMAGE_NAME = 'ling-research'
        CONTAINER_REGISTRY  = 'registry.cloud.college.ucsb.edu'
    }
    stages {
        stage('Build Test Deploy') {
            agent {
                kubernetes {
                    cloud 'rke-test'
                    inheritFrom 'podman'
                }
            }
            stages{
                stage('Build') {
                    steps {
                        script {
                            if (currentBuild.getBuildCauses('com.cloudbees.jenkins.GitHubPushCause').size() || currentBuild.getBuildCauses('jenkins.branch.BranchIndexingCause').size()) {
                               scmSkip(deleteBuild: true, skipPattern:'.*\\[ci skip\\].*')
                            }
                        }
                        container('podman') {
                            echo "NODE_NAME = ${env.NODE_NAME}"
                            sh 'podman build -t localhost/$IMAGE_NAME --pull --force-rm --no-cache .'
                        }
                     }
                    post {
                        unsuccessful {
                            container('podman') {sh 'podman rmi -i localhost/$IMAGE_NAME || true'}
                        }
                    }
                }
                stage('Test') {
                    steps {
                        container('podman') {
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME which rstudio'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME which ngram'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME R -q -e "getRversion() >= \\"4.5.2\\"" | tee /dev/stderr | grep -q "TRUE"'
                            // Python Package Import Tests
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import arpa"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import gensim"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import keras"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import matplotlib"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import morfessor"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import nltk"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import numpy"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import pandas"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "from prettytable import PrettyTable"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import pytest"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import requests"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import sklearn; sklearn.show_versions()"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import spacy"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import tensorflow"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import textgrid"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import tgt"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME python -c "import torch"'
                            // R Package Library Tests
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"bayestestR\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ca\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"CCA\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"cowplot\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"DirichletReg\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"doParallel\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ellipse\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"factoextra\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"FactoMineR\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggalluvial\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"GGally\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggbreak\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggfittext\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggforce\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggmosaic\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggplot2\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ggrepel\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"glossr\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"keras\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"lmerTest\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"mclust\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"ordinal\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"plotly\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"MASS\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"pvclust\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"reticulate\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"rjson\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"rezonateR\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"see\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"spacyr\")"'
                            sh 'podman run -it --rm --pull=never localhost/$IMAGE_NAME Rscript -e "library(\"vowels\")"'
                            sh 'podman run -d --name=$IMAGE_NAME --rm --pull=never -p 8888:8888 localhost/$IMAGE_NAME start-notebook.sh --NotebookApp.token="jenkinstest"'
                            sh 'sleep 10 && curl -v http://localhost:8888/rstudio?token=jenkinstest 2>&1 | grep -P "HTTP\\S+\\s[1-3][0-9][0-9]\\s+[\\w\\s]+\\s*$"'
                            sh 'curl -v http://localhost:8888/lab?token=jenkinstest 2>&1 | grep -P "HTTP\\S+\\s200\\s+[\\w\\s]+\\s*$"'
                            sh 'curl -v http://localhost:8888/tree?token=jenkinstest 2>&1 | grep -P "HTTP\\S+\\s200\\s+[\\w\\s]+\\s*$"'
                        }
                    }
                    post {
                        always {
                            container('podman') {sh 'podman rm -ifv $IMAGE_NAME'}
                        }
                        unsuccessful {
                            container('podman') {sh 'podman rmi -i localhost/$IMAGE_NAME || true'}
                        }
                    }
                }
                stage('Deploy') {
                    when { branch 'main' }
                    environment {
                        DOCKER_HUB_CREDS = credentials('harbor-registry-token')
                    }
                    steps {
                        container('podman') {
                            sh 'skopeo copy containers-storage:localhost/$IMAGE_NAME docker://$CONTAINER_REGISTRY/ucsb/$IMAGE_NAME:latest --dest-username $DOCKER_HUB_CREDS_USR --dest-password $DOCKER_HUB_CREDS_PSW'
                            sh 'skopeo copy containers-storage:localhost/$IMAGE_NAME docker://$CONTAINER_REGISTRY/ucsb/$IMAGE_NAME:v$(date "+%Y%m%d") --dest-username $DOCKER_HUB_CREDS_USR --dest-password $DOCKER_HUB_CREDS_PSW'
                        }
                    }
                    post {
                        always {
                            container('podman') {sh 'podman rmi -i localhost/$IMAGE_NAME || true'}
                        }
                    }
                }                
            }
            post {
                always {
                    container('podman') {sh 'podman rmi -i localhost/$IMAGE_NAME || true'}
                }
            }
        }
    }
    post {
        success {
            slackSend(username: 'jenkins', color: 'good', message: "Build ${env.JOB_NAME} ${env.BUILD_NUMBER} just finished successfull! (<${env.BUILD_URL}|Details>)")
        }
        failure {
            slackSend(username: 'jenkins', color: 'danger', message: "Uh Oh! Build ${env.JOB_NAME} ${env.BUILD_NUMBER} had a failure! (<${env.BUILD_URL}|Find out why>).")
        }
    }
}
