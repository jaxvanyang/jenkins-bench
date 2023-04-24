pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	triggers {
		pollSCM 'H/15 * * * *'
	}
	environment {
		ARCHIVE = '/resources/make-4.4.tar.gz'
		DIR = 'make-4.4'
	}
	stages {
		stage('Sequential Matrix') {
			matrix {
				options {
					lock('benchmark-lock')
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
							sh 'tar xf "${ARCHIVE}" -C .'
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
