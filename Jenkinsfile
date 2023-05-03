pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	// triggers {
	// 	pollSCM 'H/15 * * * *'
	// }
	environment {
		BUILT_IN_DOMAIN = 'localhost'
		DOCKER_DOMAIN = '172.17.0.1'
		LIBVIRT_DOMAIN = '192.168.122.1'
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
						values 'built-in', 'amd64-sid-agent', 'riscv64-sid-agent', 'arm64v8-sid-agent',
							'amd64-sid-vm', 'arm64v8-sid-vm', 'riscv64-sid-vm'
					}
					axis {
						name 'RESOURCE_DOMAIN'
						values "${BUILT_IN_DOMAIN}", "${DOCKER_DOMAIN}", "${LIBVIRT_DOMAIN}"
					}
				}
				excludes {
					exclude {
						axis {
							name 'AGENT'
							values 'built-in'
						}
						axis {
							name 'RESOURCE_DOMAIN'
							values "${DOCKER_DOMAIN}", "${LIBVIRT_DOMAIN}"
						}
					}
					exclude {
						axis {
							name 'AGENT'
							values 'amd64-sid-agent', 'riscv64-sid-agent', 'arm64v8-sid-agent'
						}
						axis {
							name 'RESOURCE_DOMAIN'
							values "${BUILT_IN_DOMAIN}", "${LIBVIRT_DOMAIN}"
						}
					}
					exclude {
						axis {
							name 'AGENT'
							values 'amd64-sid-vm', 'riscv64-sid-vm', 'arm64v8-sid-vm'
						}
						axis {
							name 'RESOURCE_DOMAIN'
							values "${BUILT_IN_DOMAIN}", "${DOCKER_DOMAIN}"
						}
					}
				}
				stages {
					stage('Prepare') {
						steps {
							sh 'wget -qO- "http://${RESOURCE_DOMAIN}/${ARCHIVE}" | tar xz -C .'
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
