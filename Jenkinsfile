pipeline {
	agent {
		label 'amd64-sid-agent'
	}

	environment {
		ARCHIVE = '/resources/make-4.4.tar.gz'
		DIR = 'make-4.4'
	}

	stages {
		stage('Prepare') {
			steps {
				sh 'tar xf "${ARCHIVE}" -C .'
			}
		}
		stage('Clean Old Build') {
			steps {
				dir(env.DIR) {
					sh 'make clean'
				}
			}
		}
		stage('Build') {
			steps {
				dir(env.DIR) {
					sh 'make'
				}
			}
		}
		stage('Test') {
			steps {
				dir(env.DIR) {
					sh 'make check'
				}
			}
		}
	}
}

// vim: ft=groovy
