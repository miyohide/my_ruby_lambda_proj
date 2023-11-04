# frozen_string_literal: true

require 'aws-sdk-codedeploy'
require 'aws-sdk-lambda'
require 'logger'

class BeforeAllowTraffic
  @logger = Logger.new(STDOUT)
  @codedeploy_client = Aws::CodeDeploy::Client.new
  @lambda_client = Aws::Lambda::Client.new

  def invoke_lambda
    @lambda_client.invoke(
      {
        function_name: ENV["NEW_VERSION"],
        invocation_type: "RequestResponse",
        payload: "data"
      })
  end

  def self.notify_execution_status(event:, status:)
    deployment_id = event['DeploymentId']
    execution_id = event['LifecycleEventHookExecutionId']

    @codedeploy_client.put_lifecycle_event_hook_execution_status(
      {
        deployment_id: deployment_id,
        lifecycle_event_hook_execution_id: execution_id,
        status: status
      })
  end

  def self.handler(event: , context:)
    @logger.info(event)
    status = "Succeeded"

    begin
      # aws_lambda_log = invoke_lambda
      # @logger.info("status_code = [#{aws_lambda_log.status_code}], payload=[#{aws_lambda_log.payload}]")
      notify_response = notify_execution_status(event: event, status: status)
    rescue => e
      @logger.fatal(e)
      status = "Failed"
      notify_response = notify_execution_status(event: event, status: status)
    ensure
      @logger.info("notify_response=[#{notify_response}]")
    end
  end
end
