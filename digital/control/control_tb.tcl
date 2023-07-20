#
# Generic Simulation Command File
#

set duration "4 ms"

if { [catch version v] == 0 && [string match *ncsim* $v] } {
    puts "ncsim: Creating waveform database and probing everything..."

    database -open -shm -into waves.shm waves -default

    probe -create -database waves : -all -depth to_cells

    if { [info exists env(GUI)] && $env(GUI) } {
        set svcf_file [glob $env(SRC_DIR)/*waves.svcf]
        if { $svcf_file != {} } {
            simvision -input $svcf_file
        }
    } else {
        dumptcf -compress -flatformat -scope dut
        run $duration
        dumptcf -end

        exit
    }

} elseif [info exists vsim_version] {
    puts "modelsim: Probing everything..."
    
    log {/*}
    add wave {/*}
     
    if { [info exists env(GUI)] && $env(GUI) } {
        puts "in GUI part"
        set do_file [glob $env(SRC_DIR)/*wave.do]
        if { $do_file != {} } {
            do $do_file
        }
        run $duration 
    } else {
        puts "Hello will run 20 ms "
        run $duration

        exit
    }

} else {
    puts "some other simulator"
}
puts "and here"
