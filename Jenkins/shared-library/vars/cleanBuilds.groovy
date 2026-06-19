import jenkins.model.Jenkins
import hudson.model.Job

@NonCPS

def call(int maxBuilds = 3) {
    def deletedCount = 0
    def logger = java.util.logging.Logger.getLogger("cleanBuilds") 
    for (job in Jenkins.get().getAllItems(Job.class)) {
        if (job.name == hudson.model.Executor.currentExecutor().currentExecutable.parent.name) continue
        def recent = job.builds.limit(maxBuilds)
        for (build in job.builds) {
            if (!recent.contains(build) && !build.isBuilding()) {
                build.delete()
                deletedCount++
            }
        }
    }
    logger.info("Successfully removed old builds: ${deletedCount}")
}
