import sys
import time
from subprocess import check_output

if __name__ == '__main__':
    print("started iteration .. ")
    if len(sys.argv) != 3:
        print("py cmd: error")
        raise SystemExit

    cmd = ['./' + sys.argv[1]]
    iterations = int(sys.argv[2])

    print('cmd: ', cmd)
    print('iterations: ', iterations)

    suma = 0
    min = 100
    max = 0

    for i in range(iterations):

        value = float(check_output(cmd).decode())
        print('Value: ', value)

        suma += value
        if value < min:
            min = value
        if value > max:
            max = value

        avg = suma/iterations

        print('Min Value: ', min, '-sec')
        print('Max Value: ', max, '-sec')
        print('Average Value: ', str.format('{0:.6f}', avg), '-sec')

        print("finished iteration .. ")