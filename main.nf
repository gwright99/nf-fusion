nextflow.enable.dsl=2

process WhereAmI {
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
    '''
}


workflow {
    ints = Channel.of(1..params.procs)

    data = Channel.fromPath(params.infile)
    WhereAmI(data)
}
