package com.myorg;

import software.constructs.Construct;

import java.util.List;

import software.amazon.awscdk.Stack;
import software.amazon.awscdk.StackProps;
import software.amazon.awscdk.cxapi.VpcSubnet;
import software.amazon.awscdk.services.ec2.Instance;
import software.amazon.awscdk.services.ec2.InstanceClass;
import software.amazon.awscdk.services.ec2.InstanceSize;
import software.amazon.awscdk.services.ec2.InstanceType;
import software.amazon.awscdk.services.ec2.MachineImage;
import software.amazon.awscdk.services.ec2.Subnet;
import software.amazon.awscdk.services.ec2.SubnetConfiguration;
import software.amazon.awscdk.services.ec2.SubnetSelection;
import software.amazon.awscdk.services.ec2.SubnetType;
// import software.amazon.awscdk.Duration;
// import software.amazon.awscdk.services.sqs.Queue;
import software.amazon.awscdk.services.ec2.Vpc;
import software.amazon.awscdk.services.iam.ManagedPolicy;
import software.amazon.awscdk.services.iam.Role;
import software.amazon.awscdk.services.iam.ServicePrincipal;

public class FirecrackerStack extends Stack {
    public FirecrackerStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public FirecrackerStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        var vpcName = name("vpc");

        var pubNetA = SubnetConfiguration
            .builder()
            .name("public-subnet-A")
            .subnetType(SubnetType.PUBLIC)
            .cidrMask(24)
            .build();

        var subnetConfigurations = List.of(pubNetA);

        var vpc = Vpc.Builder.create(this, vpcName)
            .subnetConfiguration(subnetConfigurations)
            .cidr("10.0.0.0/16")
            .build();

        var policy = ManagedPolicy.fromManagedPolicyArn(this, 
            "ssm-policy", 
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore");
        
        var managedPolicies = List.of(policy);
        
        var role = Role.Builder.create(this, name("instance-role"))
            .assumedBy(new ServicePrincipal("ec2.amazonaws.com"))
            .managedPolicies(managedPolicies)
            .build();

        var vpcSubnets = SubnetSelection.builder().subnetType(SubnetType.PUBLIC).build();
        
        var amiIdSSMParam = "/aws/service/canonical/ubuntu/server/focal/stable/current/amd64/hvm/ebs-gp2/ami-id";
        var ami = MachineImage.fromSsmParameter(amiIdSSMParam);

        var instance = Instance.Builder.create(this, name("firecracker-instance"))
            .vpc(vpc)
            .vpcSubnets(vpcSubnets)
            .machineImage(ami)
            .instanceType(InstanceType.of(InstanceClass.IO3, InstanceSize.METAL))
            .role(role)
            .build();

        var instanceId = instance.getInstanceId();
        
        System.out.println("FirecrackerStack instance "+instanceId);
        System.out.println("FirecrackerStack Created");

    }

    private String name(String resourceType) {
        var user = System.getenv().getOrDefault("USER", "rhnb");
        return user + "-" + resourceType; 
    }
}
