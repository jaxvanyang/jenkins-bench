pipeline {
	agent none
	options {
		disableConcurrentBuilds()
	}
	triggers {
		pollSCM 'H * * * *'
	}
	environment {
		ARCHIVE = '/resources/ansibench-aa1fd2d0276483512f5af0c660a13e847968b4e8.tar.gz'
		DIR = 'ansibench-aa1fd2d0276483512f5af0c660a13e847968b4e8'
	}
	stages {
		stage('Prepare Matrix') {
			matrix {
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
							// fix whetstone link error
							sh 'sed -i \'s/\\$(INPUT)$/\\$(INPUT) -lm/\' "${DIR}/whetstone/makefile"'
						}
					}
				}
			}
		}
		stage('Benchmark Matrix') {
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
					axis {
						name 'SUBDIR'
						// coremark disabled because of long running
						values 'linpack', 'stream', 'whetstone', 'dhrystone', 'nbench', 'hint'
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
