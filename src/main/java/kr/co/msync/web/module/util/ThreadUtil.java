package kr.co.msync.web.module.util;

import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * Created by jspark on 2017-09-06.
 */
@Slf4j
public class ThreadUtil {

    private static ThreadUtil threadUtil = null;
    private ExecutorService executor = null;
//    private final int THREAD_LENGTH = Runtime.getRuntime().availableProcessors();

    private ThreadUtil() {
    }

    public static ThreadUtil getInstance() {
        if (threadUtil == null) {
            threadUtil = new ThreadUtil();
            threadUtil.makeThreadPool();
        }
        return threadUtil;
    }

    private void makeThreadPool(){
        executor = Executors.newCachedThreadPool();
    }

    public void execute(Runnable runnable){

        if(runnable == null) {
            return;
        }

        if(executor == null) {
            makeThreadPool();
        }

        executor.execute(runnable);
    }

    public void shutDown(){
        if(executor != null) {
            executor.shutdown();

            while (!executor.isTerminated()) {
                executor.shutdownNow();
            }

            try{
                while (!executor.awaitTermination(3, TimeUnit.SECONDS)) {
                    executor.shutdownNow();
                }
            } catch (Exception e){
                executor.shutdownNow();
                Thread.currentThread().interrupt();
            }
        } else {
            log.error("executor is null!!!!!");
        }
    }
}
