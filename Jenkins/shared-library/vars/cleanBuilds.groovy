import jenkins.model.Jenkins
import hudson.model.Job

@NonCPS

def call(int maxBuilds = 3, String currentJobName = "") {
    def buildsCount = 0
    def jobsCount = 0
    def jobs = Jenkins.get().getAllItems(Job.class).toArray()
    for (int i = 0; i < jobs.length; i++) {
        def job = jobs[i]
        if (currentJobName && job.fullName == currentJobName) {
            continue
        }
        def builds = job.builds.toArray()
        if (builds.length <= maxBuilds) {
            continue
        }
        def jobWasCleaned = false

        for (int j = maxBuilds; j < builds.length; j++) {
            def build = builds[j]
            if (build != null && !build.isBuilding()) {
                build.delete()
                buildsCount++
                jobWasCleaned = true
            }
        }
        if (jobWasCleaned) {
            jobsCount++
        }
    }
    return [
        builds: buildsCount,
        jobs: jobsCount
    ]
}
