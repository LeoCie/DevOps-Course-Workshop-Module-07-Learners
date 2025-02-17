pipeline {
    agent none
    environment {
        DOTNET_CLI_HOME = "/tmp/dotnet_cli_home"
    }
    stages {
        stage('Build and test dotnet') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                }
            }
            steps {
                sh "dotnet build"
                sh "dotnet test"
            }
        }
        stage('Build and test npm') {
            agent {
                docker { image 'node:17-bullseye' }
            }
            steps {
                dir('DotnetTemplate.Web') {
                    sh "npm install"
                    sh "npm run lint"
                    sh "npm run build"
                    sh "npm run test-with-coverage"
                    publishCoverage adapters: [istanbulCoberturaAdapter(path: 'coverage/cobertura-coverage.xml', thresholds: [[failUnhealthy: true, thresholdTarget: 'Aggregated Report', unhealthyThreshold: 90.0, unstableThreshold: 90.0]])]
                }
            }
        }
    }
}