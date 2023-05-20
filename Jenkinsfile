pipeline {
	agent none
	// triggers {
	// 	pollSCM 'H/15 * * * *'
	// }
	environment {
		ARCHIVE = 'linux-6.3.1.tar.gz'
		DIR = 'linux-6.3.1'
	}
	stages {
		stage('Build Matrix') {
			matrix {
				options {
					// lock('benchmark-lock')
					skipDefaultCheckout()
				}
				agent {
					label "${AGENT}"
				}
				axes {
					axis {
						name 'AGENT'
						values 'amd64-sid-vm'
					}
					axis {
						name 'RESOURCE_DOMAIN'
						values '192.168.122.1'
					}
				}
				stages {
					stage('Prepare') {
						steps {
							sh 'wget -qO- "http://${RESOURCE_DOMAIN}/${ARCHIVE}" | tar xz -C .'
						}
					}
					stage('Validate & Clean') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'make mrproper'
							}
						}
					}
					stage('Configure') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'make olddefconfig'
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
				}
			}
		}
	}
}

// vim: ft=groovy
