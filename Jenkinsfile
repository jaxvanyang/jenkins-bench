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
						values 'fx50j-arch', 'amd64-sid-agent', 'riscv64-sid-agent'
					}
				}
				stages {
					stage('Prepare') {
						steps {
							script {
								if (env.AGENT == 'fx50j-arch') {
									sh 'tar xf "/home/jax/Public/resources/make-4.4.tar.gz" -C .'
								} else {
									sh 'tar xf "${ARCHIVE}" -C .'
								}
							}
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
