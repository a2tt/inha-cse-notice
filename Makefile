export PROJECT_ROOT=${PWD}
export TF_VAR_lambda_package_type=Zip
export TF_VAR_lambda_package_name=${PROJECT_ROOT}/application.zip
export TF_VAR_lambda_layer_name=${PROJECT_ROOT}/lambda_layer.zip

init:
	@echo "-- Initialize Terraform workspace and backend"
	${SHELL} script/initialize.sh
	@echo ""

package:
	@echo "-- Package AWS Lambda function and layer"
	${SHELL} script/create_lambda_package.sh
	@echo ""

apply:
	@echo "-- Executing Terraform apply"
	${SHELL} script/apply.sh
	@echo ""

deploy: package apply
	@echo ""

destroy:
	@echo "-- Destroy infrastructure of Terraform"
	${SHELL} script/destroy.sh
	@echo ""

destroy_all: destroy
	@echo "-- Destroy Terraform backend"
	${SHELL} script/destroy_backend.sh
	@echo ""

cleanup:
	@echo "-- Cleanup"
	rm ${TF_VAR_lambda_package_name} ${TF_VAR_lambda_layer_name}
	@echo ""
