//validation set
//fichier = "/home/blacky/Documents/2A/CECA/progs/02 - Valse - Op.34 No.1 - in Ab.wav"
fichier = "/home/blacky/Documents/2A/CECA/progs/TheFatRat - Unity.wav"
//fichier = "/home/blacky/Documents/2A/CECA/progs/Alan Walker - Force [NCS Release].wav"
//fichier = "/home/blacky/Documents/2A/CECA/progs/Beethoven - Moonlight Sonata In C Sharp Minor - Allegretto.wav"

//training set
//fichier = "/home/blacky/Documents/2A/CECA/progs/Vexento - Pixel Party.wav"
//fichier = "/home/blacky/Documents/2A/CECA/progs/Antonio Vivaldi - The Four Seasons - Spring.wav"
//fichier = "/home/blacky/Documents/2A/CECA/progs/AdhesiveWombat - 8 Bit Adventure.wav"
//fichier = "/home/blacky/Documents/2A/CECA/progs/01 Water Music Suites Nos 1 - 3 for orchestra, HWV 348 - 350.wav"
stacksize('max')
disp(wavread(fichier, "info"))
y = wavread(fichier)

i=1
[x,Nsamples] = size(y)
pouic = Nsamples;
while y(1,i) == 0
    i = i +1
end
j = Nsamples
while y(1,j) == 0
    j = j -1
end

y = y(:,i:j)

[x,Nvals] = size(y)

//A COMMENTER POUR ANALYSER TOUT LE MORCEAU
start = floor(Nvals/2)
Ns = 400
samplesize = 1024
y = y(:,start:(start + Ns * samplesize))


freqs = 1:(samplesize/2)

[x,Nvals] = size(y)

Nsamples = floor(Nvals / samplesize)

Centroid = 0



//centroid
Centroid = 0
for i = 1:Nsamples
    ff = abs(fft(y(1,(1+ (i-1)*samplesize):(samplesize +(i-1)*samplesize))))
    s = sum(ff(1:(samplesize/2 )))
    if s ~= 0 then
        Centroid(i) = sum(freqs .* ff(1:(samplesize/2 ))) / sum(ff(1:(samplesize/2 )))
    else
        Centroid(i) = 0
    end
    
end

//plot2d(Centroid)
disp("Mean-Centroid : ")
mc = mean(Centroid)
disp(mc)

//rolloff
R=0
R(1) = 1
for i = 1:Nsamples 
ff = abs(fft(y(1,(1+ (i-1)*samplesize):(samplesize +(i-1)*samplesize)),-1))
droite = 0.85 * sum(ff(1:(samplesize/2)))
acc = sum(ff(1:R(i)))
if acc < droite then
    while(acc < droite)
        if R(i) > samplesize/2 then
            break
        end
        if R(i) == 0 then
            R(i) = 1
        end
        acc = acc + ff(R(i))
    
        R(i) = R(i) + 1
        
    end
else
    while(acc > droite)
        if R(i) < 1 then
            break
        end
        acc = acc - ff(R(i))
    
        R(i) = R(i) - 1
        
    end
end

R(i+1) = R(i)
//clf()
//plot2d(ff)
//sleep(250)
//disp(R(i))
end
//clf()
//plot2d(R)
disp("Mean-Rolloff : ")
mr = mean(R)
disp(mr)

i=1
prevff = abs(fft(y(1,(1+ (i-1)*samplesize):(samplesize +(i-1)*samplesize))))
Flux = 0
//FLUX
for i = 2:Nsamples
    
    ff = abs(fft(y(1,(1+ (i-1)*samplesize):(samplesize +(i-1)*samplesize))))
    
    Flux(i-1) = norm(ff - prevff)
    prevff = ff
end

disp("Mean-Flux : ")
//clf()
//plot2d(Flux)
mf = mean(Flux)
disp(mf)


//zerocrossings
signal = y(1,1:(Nvals - 1))
shift = y(1,2:(Nvals))

zerocross = sum(((signal > 0) & (shift < 0 )) | ((signal < 0) & (shift > 0 ))) / Nsamples

disp("ZeroCross : ")
disp(zerocross)

//lowenergy

Energies = 0

for i = 1:Nsamples
    ff = abs(fft(y(1,(1+ (i-1)*samplesize):(samplesize +(i-1)*samplesize))))
    Energies(i) = norm(ff)
end

disp("LowEnergy : ")
lowenergy = 100 * (sum(Energies < mean(Energies)) / Nsamples)
disp(lowenergy)

valeurs = [mc mr mf zerocross lowenergy]

predict(valeurs)



