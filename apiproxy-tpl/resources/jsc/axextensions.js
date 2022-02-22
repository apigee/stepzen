var graphqlresponse = JSON.parse(response.content);
print(graphqlresponse.extensions);
if(graphqlresponse.extensions && graphqlresponse.extensions["graphql-ax-metadata"]){
    var operations = graphqlresponse.extensions["graphql-ax-metadata"].operations;
    print("inside ax metadta");
    if(operations && operations[0]){
        print("inside operations");
        context.setVariable("dc_operation_1_name",operations[0].name);
        context.setVariable("dc_operation_1_latency",operations[0].avgExecutionTimeInMillis);
        context.setVariable("dc_operation_1_cachehitcount",operations[0].cacheHitCount);
   }
  delete graphqlresponse.extensions;
  if(graphqlresponse.data){
        context.setVariable("response.content",JSON.stringify(graphqlresponse));
  }

}