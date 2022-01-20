import cdsapi

c = cdsapi.Client()

c.retrieve(
    'cams-europe-air-quality-forecasts',
    {
        'model': 'ensemble',
        'date': '2019-10-01/2019-12-31',
        'format': 'netcdf',
        'variable': 'sulphur_dioxide',
        'level': '0',
        'type': 'analysis',
        'time': [
            '00:00', '01:00', '02:00',
            '03:00', '04:00', '05:00',
            '06:00', '07:00', '08:00',
            '09:00', '10:00', '11:00',
            '12:00', '13:00', '14:00',
            '15:00', '16:00', '17:00',
            '18:00', '19:00', '20:00',
            '21:00', '22:00', '23:00',
        ],
        'leadtime_hour': '0',
        'area': [
            70, -25, 30,
            45,
        ],
    },
    'SO2_oct_dec.nc')
