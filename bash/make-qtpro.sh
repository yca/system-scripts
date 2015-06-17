#!/bin/sh

PRO=$1.pro

echo 'SOURCES += \' > ${PRO}
find . -iname "*.c" -printf "\t%p \\\ \n" >> ${PRO}
echo "" >> ${PRO}

echo 'SOURCES += \' >> ${PRO}
find . -iname "*.cpp" -printf "\t%p \\\ \n" >> ${PRO}
echo "" >> ${PRO}

echo 'HEADERS += \' >> ${PRO}
find . -iname "*.h" -printf "\t%p \\\ \n" >> ${PRO}
echo "" >> ${PRO}

echo 'OTHER_FILES += \' >> ${PRO}
find . -iname "Makefile" -printf "\t%p \\\ \n" >> ${PRO}
find . -iname "*.ld" -printf "\t%p \\\ \n" >> ${PRO}
find . -iname "*.s" -printf "\t%p \\\ \n" >> ${PRO}
find . -iname "*.sh" -printf "\t%p \\\ \n" >> ${PRO}
find . -iname "*.qsh" -printf "\t%p \\\ \n" >> ${PRO}
echo "" >> ${PRO}

#echo "INCLUDEPATH += ./arch/stm32/include ./arch/stm32/include/stlib ./arch/stm32/include/cmsis" >> ${PRO}
#echo "INCLUDEPATH += ./os/freertos/include ./os/freertos/portable/cm3" >> ${PRO}
#echo "INCLUDEPATH += ./include" >> ${PRO}
#echo "INCLUDEPATH += ./apps/include" >> ${PRO}
echo "" >> ${PRO}
