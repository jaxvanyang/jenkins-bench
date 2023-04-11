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
		dir(env.DIR) {
			stage('Clean Old Build') {
				steps {
					sh 'make clean'
				}
			}
			stage('Build') {
				steps {
					sh 'make'
				}
			}
			stage('Test') {
				steps {
					sh 'make check'
				}
			}
		}
	}
}

// vim: ft=groovy
