for pkg in $(go list ./...); do
    go test -bench=. -v -o build_43879aa/$(basename $pkg).test -cpuprofile=build_43879aa/$(basename $pkg).cpu.out $pkg
    if [ $? -eq 0 ]; then
            go tool pprof -gif build_43879aa/$(basename $pkg).test build_43879aa/$(basename $pkg).cpu.out > build_43879aa/$(basename $pkg)_cpu.gif
            if [ $? -ne 0 ]; then
                echo "Ошибка при выполнении go tool pprof для пакета $pkg"
                rm build_43879aa/$(basename $pkg)_cpu.gif
            fi
    else
        echo "Ошибка при выполнении go test для пакета $pkg"
        continue
    fi
done