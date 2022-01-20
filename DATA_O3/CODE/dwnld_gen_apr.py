import cdsapi

c = cdsapi.Client()

import cdsapi

c = cdsapi.Client()

c.retrieve(
    'cams-europe-air-quality-forecasts',
    {
        'model': 'ensemble',
        'date': '2019-05-01/2019-07-31',
        'format': 'netcdf',
        'variable': 'ozone',
        'level': '0',
        'type': 'analysis',
        'time': [
            '08:00',
            '09:00', '10:00', '11:00',
            '12:00', '13:00', '14:00',
            '15:00', '16:00', '17:00',
            '18:00', '19:00', '20:00',
            ],
        'leadtime_hour': '0',
        'area': [
            70, -25, 30,
            45,
        ],
    },
    'O3_grw_sns_dayl_2019_veg_agr.nc')
