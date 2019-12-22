String stashFileList = '*.gz,*.bz2,*.xz,*.deb,*.ddeb,*.dsc,*.changes,*.buildinfo,lintian.txt'
String archiveFileList = '*.gz,*.bz2,*.xz,*.deb,*.ddeb,*.dsc,*.changes,*.buildinfo'

pipeline {
  agent any
  stages {
    stage('Build source') {
      steps {
        sh '/usr/bin/build-source.sh'
        stash(name: 'source', includes: stashFileList)
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
      }
    }
    stage('Build binary - armhf') {
      steps {
          "Build binary - armhf": {
            node(label: 'armhf') {
              cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
              unstash 'source'
              sh '''export architecture="armhf"
build-binary.sh'''
              stash(includes: stashFileList, name: 'build-armhf')
              cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
            }
          }
      }
    }
    stage('Results') {
      steps {
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
        unstash 'build-armhf'
        archiveArtifacts(artifacts: archiveFileList, fingerprint: true, onlyIfSuccessful: true)
        sh '''/usr/bin/build-repo.sh'''
      }
    }
    stage('Cleanup') {
      steps {
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
      }
    }
  }
}
