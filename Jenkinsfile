pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	// triggers {
	// 	pollSCM 'H/15 * * * *'
	// }
	environment {
		ARCHIVE = 'jdk-jdk-18-ga.tar.gz'
		DIR = 'jdk-jdk-18-ga'
		JTREG_ARCHIVE = 'jtreg-7.2+1.tar.gz'
		JTREG_DIR = 'jtreg'
		GTEST_ARCHIVE = 'googletest-1.13.0.tar.gz'
		GTEST_DIR = 'googletest-1.13.0'
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
							// dir(env.DIR) {
							// 	sh 'mkdir -p third_party'
							// 	sh 'wget -qO- "http://${RESOURCE_DOMAIN}/${JTREG_ARCHIVE}" | tar xz -C third_party'
							// 	sh 'wget -qO- "http://${RESOURCE_DOMAIN}/${GTEST_ARCHIVE}" | tar xz -C third_party'
							// }
						}
					}
					stage('Configure') {
						steps {
							echo "${AGENT}"
							dir(env.DIR) {
								sh '''
									bash configure \
										--disable-warnings-as-errors \
										--with-num-cores=1 \
										--with-memory-size=1024
								'''
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
								sh 'make images'
							}
						}
					}
					// stage('Test') {
					// 	steps {
					// 		echo "${AGENT}"
					// 		dir(env.DIR) {
					// 			sh 'make run-test-tier1'
					// 		}
					// 	}
					// }
				}
			}
		}
	}
}

// vim: ft=groovy
