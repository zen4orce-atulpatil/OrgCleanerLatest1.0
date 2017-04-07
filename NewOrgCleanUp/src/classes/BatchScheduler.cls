global class BatchScheduler implements Schedulable {
  global Database.Batchable<Id> batchClass{get;set;}
  global Integer batchSize{get;set;} {batchSize = 10;}
  global static boolean schedulestatus{get;set;}

  global void execute(SchedulableContext sc) {
  	    Configurationselector configurationSelectorInstance = new Configurationselector();
  		boolean condition;
  		if(batchClass!=null){
			List<AsyncApexJob> lstAsyncApexJobNew=new List<AsyncApexJob>();
			List<String> lstJobNames=new List<String>();
			lstJobNames.add('CommentDependentPagesBatch');
			lstJobNames.add('CommentDependentClassBatch');
			lstJobNames.add('CommentDependentTriggersBatch');
			lstAsyncApexJobNew=configurationSelectorInstance.getAsyncApexJobStatus(lstJobNames);
			/*if(test.isRunningTest())
			{
				condition=true; 
				//database.executebatch(batchClass, batchSize);
				//schedulestatus=true;
			}
			else
            {*/
				condition=lstAsyncApexJobNew[0].status=='Completed' && lstAsyncApexJobNew[1].status=='Completed' && lstAsyncApexJobNew[2].status=='Completed';
			//}
			
			if(condition)
			{
				database.executebatch(batchClass, batchSize);
				schedulestatus=true;
			}
			else 
            {
					ConfigurationCleanUpServiceHandler.ScheduleDeletionBatch();
					schedulestatus=false;
			}
			
  		}
  }
  
}