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
		stage('Sequential Matrix') {
			matrix {
				options {
					lock('synchronous-matrix')
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
						values 'linpack', 'stream', 'whetstone', 'dhrystone', 'nbench', 'coremark', 'hint'
					}
				}
				stages {
					stage('Prepare') {
						steps {
							sh 'tar xf "${ARCHIVE}" -C . --skip-old-files'
						}
					}
					stage('Clean Old Build') {
						steps {
							echo "${AGENT}/${SUBDIR}"
							dir("${DIR}/${SUBDIR}") {
								sh 'make clean'
							}
						}
					}
					stage('Build') {
						steps {
							echo "${AGENT}/${SUBDIR}"
							dir("${DIR}/${SUBDIR}") {
								sh 'make'
							}
						}
					}
					stage('Run Benchmark') {
						steps {
							echo "${AGENT}/${SUBDIR}"
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
