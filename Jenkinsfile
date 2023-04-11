pipeline {
	agent none
	environment {
		ARCHIVE = '/resources/make-4.4.tar.gz'
		DIR = 'make-4.4'
	}
	stages {
		stage('Matrix') {
			matrix {
				agent {
					label "${AGENT}"
				}
				axes {
					axis {
						name 'AGENT'
						values 'fx50j-arch', 'amd64-sid-agent'
					}
				}
				stages {
					stage('Prepare') {
						steps {
							sh 'tar xf "${ARCHIVE}" -C .'
						}
					}
					stage('Configure') {
						steps {
							dir(env.DIR) {
								sh './configure'
							}
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
		}
	}
}

// vim: ft=groovy
