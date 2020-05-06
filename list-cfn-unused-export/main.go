package main

import (
	"fmt"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cloudformation"
)

func listStacks(sess *session.Session, token *string, result map[string]string) {
	time.Sleep(1 * time.Second)
	service := cloudformation.New(sess)
	params := &cloudformation.ListStacksInput{
		NextToken: token,
	}
	resp, err := service.ListStacks(params)
	if err != nil {
		panic(err)
	}
	for _, stack := range resp.StackSummaries {
		result[aws.StringValue(stack.StackId)] = aws.StringValue(stack.StackName)
	}
	if resp.NextToken != nil {
		listStacks(sess, resp.NextToken, result)
	}
}

func listExports(sess *session.Session, token *string, result map[string]string) {
	time.Sleep(1 * time.Second)
	service := cloudformation.New(sess)
	params := &cloudformation.ListExportsInput{
		NextToken: token,
	}
	resp, err := service.ListExports(params)
	if err != nil {
		panic(err)
	}
	for _, export := range resp.Exports {
		result[aws.StringValue(export.Name)] = aws.StringValue(export.ExportingStackId)
	}

	if resp.NextToken != nil {
		listExports(sess, resp.NextToken, result)
	}
}

func listImports(sess *session.Session, exportName string, token *string, result *[]string) {
	time.Sleep(1 * time.Second)
	service := cloudformation.New(sess)
	params := &cloudformation.ListImportsInput{
		NextToken:  token,
		ExportName: aws.String(exportName),
	}
	resp, err := service.ListImports(params)
	if err != nil {
		if aerr, ok := err.(awserr.Error); ok {
			if aerr.Code() == "ValidationError" && strings.Contains(aerr.Message(), "is not imported by any stack") {
				return
			}
		}
		panic(err)
	}
	for _, _import := range resp.Imports {
		*result = append(*result, aws.StringValue(_import))
	}

	if resp.NextToken != nil {
		fmt.Println("next token exists")
		listImports(sess, exportName, resp.NextToken, result)
	}
}

func main() {
	sess := session.Must(session.NewSession())
	// if you use profile
	// sess := session.Must(
	// 	session.NewSessionWithOptions(
	// 		session.Options{
	// 			Profile: "myProfile",
	// 		},
	// 	),
	// )

	stacks := make(map[string]string)
	listStacks(sess, nil, stacks)
	exports := make(map[string]string)
	listExports(sess, nil, exports)
	fmt.Println("following exports value is not used in any stack.")
	for key, _ := range exports {
		var result []string
		listImports(sess, key, nil, &result)
		if len(result) == 0 {
			fmt.Printf("%s defined in %s\n", key, stacks[exports[key]])
		}
	}
}
