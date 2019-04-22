### First follow  [Spotinst How-to start](https://api.spotinst.com/provisioning-ci-cd-sdk/provisioning-tools/terraform/installation/)


- Add spotinst_token and spotinst_account under secrets/ (on .gitignore)


[EXAMPLE]
`terraform plan -out=tfplan -input=false -var-file='terraform.tfvars' -var-file='secrets/michael-spotinst-token.tfvars' -var-file='secrets/spotinst-account-id.tfvars'`
