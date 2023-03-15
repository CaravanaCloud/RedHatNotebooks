#!/bin/bash

# Setup your pull secret
export REGISTRY_AUTH_FILE=$HOME/.podman/auth.json

images=("quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:f6488d79fe2ec4081904fea31a582aad4192ba62f2dcbddfe3ef50202748a28e"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:c74fcd7470b682be673ccbc763ac25783f6997a253c8ca20f63b789520eb65bf"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:84ec1f865f595a3d0d36a7149ebcb959c6a5aa5e24333ca9d378d9496a9a91ae"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:2037fa0130ef960eef0661e278466a67eccc1460d37f7089f021dc94dfccd52b"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:924e1f8672e3d6bf42997489edab26998999e960d81cd0e0491ac39d278fe48f"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:c263b11dcd5304d779999f2540a30ea190b3a0f760a2e246c96d37a92c0f3492"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:e40f30a04d66ff1fc06d7b46f2f02da87269a1e11d79c2ab3db77d7d021cc163"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:e7da6fad74fc1437c265d512669f75f238e9da7cb8c179d43f40db30a2e8bec7"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:756f3f02d7592b100d5fcf2a8351a570102e79e02425d9b5d3d09a63ee21839d"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:917b84445c725430f74f2041baa697d86d2a0bc971f6b9101591524daf8053f6"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:782acf9917df2dff59e1318fc08487830240019e5cc241e02e39a06651900bc2"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:d1705c63614eeb3feebc11b29e6a977c28bac2401092efae1d42b655259e2629"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:7ecf76246d81adfe3f52fdb54a7bddf6b892ea6900521d71553d16f2918a2cac"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:503846d640ded8b0deedc7c69647320065055d3d2a423993259692362c5d5b86"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:30784b4b00568946c30c1830da739d61193a622cc3a17286fe91885f0c93af9f"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:6db665511f305ef230a2c752d836fe073e80550dc21cede3c55cf44db01db365"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:1b967b048fac8006b51e715dfc1720ee3f3dd6dadff6baab4fd07c3ec378a6f0"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:7c23b71619bd88c1bfa093cfa1a72db148937e8f1637c99ff164bf566eaf78b8"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:87d28ea25934e84f93eea0235344d33039c5ee5cce80ca5a1a0c8bca82797f5d"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:14794ac4b4b5e1bb2728d253b939578a03730cf26ba5cf795c8e2d26b9737dd6"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:51c76ce72315ae658d91de6620d8dd4f798e6ea0c493e5d2899dd2c52fbcd931"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:7233826e59b2b730c43c257f81971b8f517df42ba43469af61822fdd88ebff32"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:00d1be95201020c5cb1d3fae3435ee9e7dc22d8360481ec8609fa368c6ad306e"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:d4edb2f3ffbd1a017d150cd1d6fca7f3cdc6a1a4e34c21a6aee0ab0366920bf0"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:a8e933351f3a010239ecfe1bdc74a8e2502b29fd7b7c05fcccfc2d48e980ea2c"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:fc5cd7d5ac1dcb4049a819e3e557ec78991bc01fd2d5fee252c284a37c0ec631"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:e0c13c6d2ab5436bf18211b15bf2ca9d3798964f5e03ed761c0e4708cf8d4e88"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:1ddea003dd0de85bb4f6d7e9106c54125858a162fe1fda1f238258418fcb52e8"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:89cea54cc62014f0c2709b27942fdae5f7613e8f1540ea51b44328cf166b987f"
"quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:80a6200b0c18486bad5abe5804a62bed7436daa56f0296e7b19c18f84b3b8b1b"
)



for i in "${images[@]}" 
do    
    podman pull --authfile 'pull-secret.json'  \
        --storage-opt ignore_chown_errors=true \
        $i > /dev/null 2>&1
    if [ $? -eq 0 ]; then
    echo -n "OK"
    else
    echo -n "FAIL"
    fi
    echo " $i"
done