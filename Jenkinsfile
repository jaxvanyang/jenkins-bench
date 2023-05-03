pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	// triggers {
	// 	pollSCM 'H/15 * * * *'
	// }
	environment {
		RESOURCE_ROOT = 'http://172.17.0.1'
		ARCHIVE = 'make-4.4.tar.gz'
		DIR = 'make-4.4'
	}
	stages {
		stage('Build Matrix') {
			matrix {
				options {
					lock('benchmark-lock')
					skipDefaultCheckout()
				}
				agent {
					label "${AGENT}"
				}
				axes {
					axis {
						name 'AGENT'
						values 'built-in', 'amd64-sid-agent', 'riscv64-sid-agent', 'arm64v8-sid-agent'
					}
				}
				stages {
					stage('Prepare') {
						steps {
							sh 'wget -qO- "${RESOURCE_ROOT}/${ARCHIVE}" | tar xz -C .'
						}
					}
					stage('Configure') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh './configure'
							}
						}
					}
					stage('Clean Old Build') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'make clean'
							}
						}
					}
					stage('Build') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'make'
							}
						}
					}
					stage('Test') {
						steps {
							echo "${AGENT}"
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
