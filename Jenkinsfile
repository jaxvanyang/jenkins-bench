pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	// triggers {
	// 	pollSCM 'H/15 * * * *'
	// }
	environment {
		ARCHIVE = 'gcc-12.2.0.tar.gz'
		DIR = 'gcc-12.2.0'
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
						values 'built-in', 'amd64-sid-agent', 'riscv64-sid-agent', 'arm64v8-sid-agent',
							'amd64-sid-vm', 'arm64v8-sid-vm', 'riscv64-sid-vm'
					}
					axis {
						name 'RESOURCE_DOMAIN'
						values 'localhost', '172.17.0.1', '192.168.122.1'
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
							values '172.17.0.1', '192.168.122.1'
						}
					}
					exclude {
						axis {
							name 'AGENT'
							values 'amd64-sid-agent', 'riscv64-sid-agent', 'arm64v8-sid-agent'
						}
						axis {
							name 'RESOURCE_DOMAIN'
							values 'localhost', '192.168.122.1'
						}
					}
					exclude {
						axis {
							name 'AGENT'
							values 'amd64-sid-vm', 'riscv64-sid-vm', 'arm64v8-sid-vm'
						}
						axis {
							name 'RESOURCE_DOMAIN'
							values 'localhost', '172.17.0.1'
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
								// clean old build
								sh 'make distclean'
								sh './configure'
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
								sh 'make -k check'
							}
						}
					}
				}
			}
		}
	}
}

// vim: ft=groovy
