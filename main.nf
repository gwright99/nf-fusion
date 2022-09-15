nextflow.enable.dsl=2

process WhereAmI {
    debug true
    memory 1G
    cpus 1 

    input:
    path("infile")

    output:
    path('outfile')

    '''
    pwd
    ls -al
    mv infile outfile
    echo '---'
    cp .command.sh test_for_rob.sh
    ls -al
    echo '---'
    cp .command.sh /fusion/s3/dovetailtroubleshooting/loxofusion/this_was_uploaded_via_fusion_cp.sh
    touch /fusion/s3/dovetailtroubleshooting/loxofusion/this_was_created_by_touch_via_WhereAmI_process.txt
    '''
}


process DoesInputUseFusion {
    memory 1G
    cpus 1 

    input:
    path(infile)

    "du -sh $infile"
}


workflow {
    ints = Channel.of(1..params.procs)

    data = Channel.fromPath(params.infile)
    WhereAmI(data) | DoesInputUseFusion
}
