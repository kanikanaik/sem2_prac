processes = {1: 1, 2: 1, 3: 0, 4: 1, 5: 1}


def bully(initiator):
    active = [p for p in processes if p > initiator and processes[p]]

    if active:
        for p in active:
            print(f"{initiator} -> ELECTION -> {p}")
        coord = max(p for p in processes if processes[p])
    else:
        coord = initiator

    print("Coordinator:", coord)


def ring(initiator):
    pids = list(processes.keys())
    i = pids.index(initiator)
    msg = []

    while True:
        pid = pids[i]
        if processes[pid]:
            print(f"{pid} passes message")
            msg.append(pid)

        i = (i + 1) % len(pids)

        if pids[i] == initiator:
            break

    print("Coordinator:", max(msg))


while True:
    print("\n1.Bully  2.Ring  3.Exit")
    ch = int(input("Choice: "))

    if ch == 3:
        break

    for p, s in processes.items():
        print(f"Process {p}: {'Active' if s else 'Down'}")
    init = int(input("Initiator: "))

    if ch == 1:
        bully(init)
    else:
        ring(init)
