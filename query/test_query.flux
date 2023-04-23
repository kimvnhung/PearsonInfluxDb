import "generate"
import "date"
import "experimental"

subStream = (A=<-, count, offset1) => {
    return A
            |> limit(n: count, offset: offset1)
}

getRow = (tables=<-, field, idx=0) => {
    extract = tables
        |> findRecord(fn: (key) => true, idx: idx)

    return extract
}

baros = from(bucket: "FirstBucket")
    |> range(start: 0)
    |> filter(fn: (r) => r._measurement == "airSensors")
    |> filter(fn: (r) => r._field == "baro")
    |> map(
        fn: (r) => {
            return {r with "_time": date.truncate(t: r._time, unit: 30m)}
        },
    )

otwos =
    from(bucket: "FirstBucket")
        |> range(start: 0)
        |> filter(fn: (r) => r._measurement == "airSensors")
        |> filter(fn: (r) => r._field == "otwo")
        |> map(
            fn: (r) => {
                return {r with "_time": date.truncate(t: r._time, unit: 30m)}
            },
        )

// startTime =  baros
//             |> first()
// stopTime = baros
//             |> last()

baroTr = baros|>experimental.window(every: 100h)
otwoTr = otwos|>experimental.window(every: 100h)

pearson