from django.db import models


class lab01(models.Model):
    
    pid = models.CharField(
        max_length=16
    )

    protocolnumber = models.CharField(
        max_length=7,
        null=True
    )

    headerdate = models.DateTimeField(
        null=True
    )

    tid = models.CharField(
        max_length=6
    )

    pat_id = models.CharField(
        max_length=25
    )

    other_pat_ref = models.CharField(
        max_length=50
    )

    sample_protocolnumber = models.CharField(
        max_length=7,
        null=True
    )

    class Meta:
        app_label = 'dmis_scripts'