pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	// triggers {
	// 	pollSCM 'H/15 * * * *'
	// }
	environment {
		ARCHIVE = 'apache-tomcat-10.1.8-src.tar.gz'
		DIR = 'apache-tomcat-10.1.8-src'
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
					stage('Validate') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'ant validate'
							}
						}
					}
					stage('Clean Old Build') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'ant clean'
							}
						}
					}
					stage('Build') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'ant'
							}
						}
					}
					stage('Test') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh 'output/build/bin/version.sh'
							}
						}
					}
				}
			}
		}
	}
}

// vim: ft=groovy
