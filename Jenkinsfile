pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	// triggers {
	// 	pollSCM 'H * * * *'
	// }
	environment {
		ARCHIVE = 'ansibench-aa1fd2d0276483512f5af0c660a13e847968b4e8.tar.gz'
		DIR = 'ansibench-aa1fd2d0276483512f5af0c660a13e847968b4e8'
	}
	stages {
		stage('Prepare Matrix') {
			matrix {
				options {
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
							// fix whetstone & nbench link error
							sh 'sed -i \'s/\\$(INPUT)$/\\$(INPUT) -lm/\' "${DIR}/whetstone/makefile"'
							sh 'sed -i \'s/\\$(INPUT)$/\\$(INPUT) -lm/\' "${DIR}/nbench/makefile"'
						}
					}
				}
			}
		}
		stage('Benchmark Matrix') {
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
						name 'SUBDIR'
						// disable hint & coremark because of long running
						// disable nbench because of error
						values 'whetstone'
					}
				}
				stages {
					stage('Benchmark Stage') {
						steps {
							echo "${AGENT} - ${SUBDIR}"
							dir("${DIR}/${SUBDIR}") {
								sh 'make run'
							}
						}
					}
				}
			}
		}
	}
}

// vim: ft=groovy
