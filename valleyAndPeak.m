function D = valleyAndPeak(D, files);
    for fileIndex = 1:length(files)
        for m = 1:length(D{fileIndex}.Chosen_mk)
            figure;
            % Extract file name from the full file path
            [~, fileName, ~] = fileparts(D{fileIndex}.filePath);

            F = D{fileIndex}.frame(D{fileIndex}.startTime * 120 + 1:D{fileIndex}.endTime * 120);
            T = D{fileIndex}.time(D{fileIndex}.startTime * 120 + 1:D{fileIndex}.endTime * 120);

            for dim = {'x', 'y', 'z'}
                subplot(3, 1, find(strcmp(dim, {'x', 'y', 'z'})));

                data = -D{fileIndex}.(dim{:})(F, D{fileIndex}.Chosen_mk(m));
                [peaks, peakLocs] = findpeaks(data, F);
                [valleys, valleyLocs] = findpeaks(-data, F);

                D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_peaks']) = peaks;
                D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_peakLocs']) = peakLocs;
                D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_valleys']) = -valleys;
                D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_valleyLocs']) = valleyLocs;

                plot(T, -data);
                hold on;
                plot(D{fileIndex}.time(D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_peakLocs'])), ...
                    -D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_peaks']), 'ro', 'MarkerSize', 10);
                plot(D{fileIndex}.time(D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_valleyLocs'])), ...
                    -D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.([dim{:} '_valleys']), 'go', 'MarkerSize', 10);
                xlabel('Time');
                ylabel(dim{:});
                title([D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.MarkerName, '  File: ',fileName],'Interpreter', 'none');
                legend('Original Data', 'Found Peaks', 'Found Valleys');
            end
        end
    end
end
