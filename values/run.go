package values

import (
	"fmt"
	"gobot.io/x/gobot"
	"gobot.io/x/gobot/drivers/i2c"
	"gobot.io/x/gobot/platforms/raspi"
)

func Run() error {
	adaptor := raspi.NewAdaptor()
	bmp280 := i2c.NewBMP280Driver(adaptor, i2c.WithBus(1), i2c.WithAddress(0x76))

	work := func() {
		t, _ := bmp280.Temperature()
		fmt.Println("Temperature", t)

		p, _ := bmp280.Pressure()
		fmt.Println("Pressure", p)

		a, _ := bmp280.Altitude()
		fmt.Println("Altitude", a)
	}

	robot := gobot.NewRobot("bmp280bot",
		[]gobot.Connection{adaptor},
		[]gobot.Device{bmp280},
		work,
	)

	return robot.Start()
}
